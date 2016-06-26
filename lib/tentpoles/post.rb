module Tentpoles
  class Post < LawntentResource

    def initialize(post_uri, description = nil)
      @post_uri = post_uri  
      if description
        @description = description.to_h
      else
        @description = get_response(post_uri)
      end
      build_field_accessors(@description)

      rescue => ex
        pp ex
        throw ex
    end

    def fields
      @description.keys
    end

    def created_at
      Time.parse(@description["created_at"])
    end
  end
end

