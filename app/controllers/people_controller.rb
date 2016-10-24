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

  def groups
    if request.post?
      per_page  = params[:param_per_page].blank? ? 10 : params[:param_per_page].to_i
      page      = params[:param_page].blank? ? 1 : params[:param_page].to_i
      usr_id    = user_id(params[:user_id_or_url])
      begin
        groups = flickr.people.getGroups(user_id: usr_id)
      rescue FlickRaw::FailedResponse => e
        flash[:error] = e.message
        return
      end

      start_idx     = (page - 1) * per_page
      target_groups = groups.to_a[start_idx, per_page]
      target_groups = target_groups.map{ |group| group.to_hash }

      target_groups.each do |group|
        group[:photos] = []
        begin
          group[:photos] = flickr.groups.pools.getPhotos(group_id: group['nsid'], 
                                                        user_id: usr_id)
        rescue FlickRaw::FailedResponse => e
          group[:err] = e
        end

        puts "#{group[:photos].size.to_s.rjust(3, ' ')} photos | #{group['name']}"
      end
      @out = target_groups
    end
  end

private
  def user_id(user_id_or_url)
    # https://www.flickr.com/photos/jellybeanzgallery/29883393633/in/explore-2016-10-23/
    # 38954353@N06
    if url?(user_id_or_url)
      begin
        user_id = flickr.urls.lookupUser(url: user_id_or_url).id
      rescue FlickRaw::FailedResponse => e
        flash[:error] = e.message
        return
      end
    else
      user_id = user_id_or_url
    end

    user_id
  end

  def url?(str)
    str =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

end
