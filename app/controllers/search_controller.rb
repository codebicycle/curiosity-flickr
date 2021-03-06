class SearchController < ApplicationController

  def index
    if request.post?
      converted_params = convert_params(params)

      photos = flickr.photos.search(converted_params)
      pagination = gen_page_numbers(current_page: photos.page,
                                      max_page: photos.pages)
      @out = {photos: photos,
              pagination: pagination}
    end
  end

end
