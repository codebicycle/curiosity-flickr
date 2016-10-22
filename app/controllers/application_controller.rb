class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

private
  def convert_params(params_hash)
    params_hash
      .select { |k,v| k.start_with?('param') and !v.blank? }
      .map { |k,v| [k.sub('param_', '').to_sym, v] }
      .to_h
  end

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
