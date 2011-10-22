# encoding: utf-8

require 'spec_helper'

describe Mongomap::Document do

  it 'should insert into the collection' do
    p = Person.new :name => 'Patrick'
    p.save!
    p = Person.new :name => 'John'
    p.save!

    Person.first.name.should == 'Patrick'
  end

end
