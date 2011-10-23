# encoding: utf-8

require 'spec_helper'

describe Mongomap::Document do

  before do
    Person.delete_all
    p = Person.new :name => 'Patrick'
    p.save!
    p = Person.new :name => 'John'
    p.save!
    p = Person.new :name => 'Doe'
    p.save!
  end

  it 'should get the first document' do
    Person.first.name.should == 'Patrick'
  end

  it 'should get the last document' do
    Person.last.name.should == 'Doe'
  end

  it 'should serialize' do
    p = Person.new :name => 'Patrick'
    p.to_json.should == "{\"person\":{\"name\":\"Patrick\"}}"
    p.save!

    needle = "{\"person\":{\"_id\":{\"$oid\":\"#{p._id}\"},\"name\":\"Patrick\"}}"

    p.to_json.should == needle
    Person.last.to_json.should == needle
  end

  it 'should execute server-side queries' do
    people = Person.find do
      if this[:name] == 'John'
        emit(this[:_id],this)
      end
    end
    people.size.should == 1
    people.first.name.should == 'John'
  end

end
