module Tentpoles
  class LawntentResource
  
    private

    def get_response(uri)
      req = Net::HTTP::Get.new(uri)
      req.content_type = 'application/json'
      res = Net::HTTP.start(uri.hostname, uri.port) { |http| http.request(req) }
      case res
      when Net::HTTPSuccess, Net::HTTPFound
        JSON.parse(res.body)
      when Net::HTTPNotFound
        throw "Resource not found"
      when Net::HTTPUnauthorized
        throw "Not authorized to view this resource"
      else
        throw "Some random issue"
      end
    end

    def create_method(name, &block)
      self.class.send(:define_method, name, &block)
    end

    def build_field_accessors(description)
      description.keys.each do |field|
        pp field
        create_method(field.to_sym) { description[field] }
      end
    end
  end
end
