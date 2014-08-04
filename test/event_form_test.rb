require "test_helper"

class EventAttributesTest < ActiveSupport::TestCase
  attr_accessor :params
  
  
  context "Given a start_time and start_date" do
    setup do
      self.params = {
        "start_date" => "2014-04-15",
        "start_time" => "4:50 PM"
      }.with_indifferent_access
    end
    
    should "combine them to assign starts_at" do
      attributes = EventAttributes.new(params).to_h
      assert_equal Time.utc(2014, 4, 15, 16, 50), attributes[:starts_at]
    end
  end
  
  
  context "with local time" do
    setup do
      Time.zone = "Eastern Time (US & Canada)"
    end
    
    context "Given a start_time and start_date" do
      setup do
        self.params = {
          "start_date" => "2014-04-15",
          "start_time" => "4:50 PM"
        }.with_indifferent_access
      end
      
      should "combine them to assign starts_at" do
        attributes = EventAttributes.new(params).with_local_time.to_h
        assert_equal Time.zone.local(2014, 4, 15, 16, 50), attributes[:starts_at]
      end
    end
  end
  
  
  context "Given just a start_date" do
    setup do
      self.params = {
        "start_date" => "2014-04-15"
      }.with_indifferent_access
    end
    
    should "assign the date to starts_at" do
      attributes = EventAttributes.new(params).to_h
      assert_equal Date.new(2014, 4, 15), attributes[:starts_at]
    end
  end
  
  
  context "Given an invalid time" do
    setup do
      self.params = {
        "start_date" => "2014-04-15",
        "start_time" => "nope"
      }.with_indifferent_access
    end
    
    should "assign the date to starts_at" do
      attributes = EventAttributes.new(params).to_h
      assert_equal Date.new(2014, 4, 15), attributes[:starts_at]
    end
  end
  
  
  context "Given a blank time" do
    setup do
      self.params = {
        "start_date" => "2014-04-15",
        "start_time" => ""
      }.with_indifferent_access
    end
    
    should "assign the date to starts_at" do
      attributes = EventAttributes.new(params).to_h
      assert_equal Date.new(2014, 4, 15), attributes[:starts_at]
    end
  end
  
  
  context "Given an invalid date" do
    setup do
      self.params = {
        "start_date" => "nope"
      }.with_indifferent_access
    end
    
    should "assign nil to starts_at" do
      attributes = EventAttributes.new(params).to_h
      assert_equal nil, attributes[:starts_at]
    end
  end
  
  
end
