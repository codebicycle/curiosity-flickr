class SearchController < ApplicationController

  def index
    if request.post?
      mod_params = params
                    .select { |k,v| k.start_with?('param') and !v.blank? }
                    .map { |k,v| [k.sub('param_', '').to_sym, v] }
                    .to_h

      @photos = flickr.photos.search(mod_params)
    end
  end

end
