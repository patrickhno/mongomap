# encoding: utf-8

require 'spec_helper'

describe Mongomap::Document do

  it 'should get the first document' do
    p = Person.new :name => 'Patrick'
    p.save!
    p = Person.new :name => 'John'
    p.save!

    Person.first.name.should == 'Patrick'
  end

  it 'should get the last document' do
    p = Person.new :name => 'Patrick'
    p.save!
    p = Person.new :name => 'John'
    p.save!

    Person.last.name.should == 'John'
  end

  it 'should serialize' do
    p = Person.new :name => 'Patrick'
    p.to_json.should == "{\"person\":{\"name\":\"Patrick\"}}"
    p.save!

    needle = "{\"person\":{\"_id\":{\"$oid\":\"#{p._id}\"},\"name\":\"Patrick\"}}"

    p.to_json.should == needle

    Person.last.to_json.should == needle
  end

end
