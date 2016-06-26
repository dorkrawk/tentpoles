module Tentpoles
  class Collection < LawntentResource
   
    attr_reader :description

    def initialize(base_url)
      @base_url= base_url
      @description = get_response(collection_uri)
      build_field_accessors(description)

      rescue => ex
        pp ex
        throw ex 
    end

    def post(post_id = nil)
      if post_id  
        Tentpoles::Post.new(post_uri(post_id))
      else
        posts(1).first
      end
    end

    def posts(limit = 5)
      raw_posts = get_response(posts_uri(limit))
      raw_posts.map { |p| Tentpoles::Post.new(post_uri(p["post_id"]), p) }
    end

    private

    def collection_uri
      collection_json_url = @base_url + ".json"
      URI(collection_json_url)
    end

    def post_uri(post_id)
      post_json_url = @base_url + "/#{post_id}.json" 
      URI(post_json_url)
    end

    def posts_uri(limit)
      posts_json_url = @base_url + "/posts/#{limit}.json"
      URI(posts_json_url)
    end
  end
end
