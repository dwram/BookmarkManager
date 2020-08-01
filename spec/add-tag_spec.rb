require_relative './spec_helper'
require_relative '../models/tag'

describe Tag do

  it 'new tag' do
    generate_example_bookmarks
    expect(Tag.add(content: 'Example tag').content).to include 'Example tag'
  end

end
