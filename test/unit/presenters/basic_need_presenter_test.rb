require_relative '../../test_helper'

class BasicNeedPresenterTest < ActiveSupport::TestCase

  setup do
    @need = OpenStruct.new(
      id: "blah-bson-id",
      need_id: 123456,
      role: "business owner",
      goal: "find out the VAT rate",
      benefit: "I can charge my customers the correct amount",
      organisation_ids: [ "ministry-of-testing" ],
      organisations: [
        OpenStruct.new(id: "ministry-of-testing", name: "Ministry of Testing", slug: "ministry-of-testing")
      ]
    )
    @presenter = BasicNeedPresenter.new(@need)
  end

  should "return a need as json" do
    response = @presenter.as_json

    assert_equal "ok", response[:_response_info][:status]
    assert_equal 123456, response[:id]

    assert_equal "business owner", response[:role]
    assert_equal "find out the VAT rate", response[:goal]
    assert_equal "I can charge my customers the correct amount", response[:benefit]

    assert_equal ["ministry-of-testing"], response[:organisation_ids]

    assert_equal 1, response[:organisations].size
    assert_equal "Ministry of Testing", response[:organisations][0][:name]
    assert_equal "ministry-of-testing", response[:organisations][0][:id]
  end

end