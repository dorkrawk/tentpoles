require 'spec_helper'
require 'pp'

describe Tentpoles::Collection do

  it "should exist" do
    collection = Tentpoles::Collection.new("http://localhost:3000/blog")
    pp collection
    pp collection.description
    pp collection.title

    post = collection.post
    pp post
    pp post.fields
    pp post.created_at
#    pp post.title
    #pp post.comic

    pp ""
    pp ""

    pp collection.posts(3)
  end
end
