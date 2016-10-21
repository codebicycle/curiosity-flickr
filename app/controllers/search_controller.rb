class SearchController < ApplicationController

  def index
    if request.post?
      mod_params = params
                    .select { |k,v| k.start_with?('param') and !v.blank? }
                    .map { |k,v| [k.sub('param_', '').to_sym, v] }
                    .to_h

      photos = flickr.photos.search(mod_params)
      pagination = gen_page_numbers(current_page: photos.page,
                                      max_page: photos.pages)
      @out = {photos: photos,
              pagination: pagination}
    end
  end

private
  def gen_page_numbers(current_page:, max_page:)
    pagination = {}
    pagination[:current] = current_page
    pagination[:pages] = []
    pagination[:pages] += (current_page-5..current_page).select { |p| p > 0 }
    pagination[:pages] += (current_page+1..current_page+5)
                            .select {|p| p < max_page + 1 }

    pagination
  end

end
