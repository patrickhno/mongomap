# encoding: utf-8

module Mongomap

  module Document
    
    attr_writer :new_record
    
    extend ActiveSupport::Concern
    
    included do
      extend ActiveModel::Translation
      extend Mongomap::Finders
    end

    include ActiveModel::Conversion
    include ActiveModel::MassAssignmentSecurity
    include ActiveModel::Naming
    include ActiveModel::Observing
    include ActiveModel::Serializers::JSON
    include ActiveModel::Serializers::Xml

    module ClassMethods
      def field(name, options = {})
      end

      def first
        Person.new collection.first
      end
      def last
        Person.new collection.last
      end

      def collection
        unless defined? @@collection
          @@collection = {}
db = ::Mongo::Connection.new('localhost', 27017).db('test')
Morel::Collection.db = db
        end
        @@collection[self.name.to_sym] ||= Morel::Collection.new(self.name.to_sym)
      end
    end

    def initialize options
      if options.kind_of? BSON::OrderedHash
        @new_record = false
      elsif options.kind_of? Hash
        @new_record = true
      else
        raise "unsupported"
      end
      @fields = options

      # define getter methods for all the fields in the document
      options.keys.each do |key|
        self.class.send(:define_method,key) do
          @fields[key]
        end
      end
    end
    
    def new_record?
      @new_record == true
    end
    
    def insert
      self.class.collection.insert @fields
    end
    
    def save!
      if new_record?
        insert
      else
        update
      end
    end

  end

end
