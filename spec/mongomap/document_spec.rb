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

end
