class PeopleController < ApplicationController
  def photos
    if request.post?
      converted_params = convert_params(params)
      begin
        photos = flickr.people.getPhotos(converted_params)
      rescue FlickRaw::FailedResponse => e
        flash[:error] = e.message
        return
      end
      pagination = gen_page_numbers(current_page: photos.page,
                                      max_page: photos.pages)
      @out = {photos: photos,
              pagination: pagination}
    end
  end
end
