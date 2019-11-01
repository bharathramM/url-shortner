# frozen_string_literal: true

module ApplicationHelper
  def top_countries(details)
    sort = details.sort_by { |_country, detail| detail['no_of_hits'] }
    Hash[sort.reverse.first(3)].keys.join(', ')
  end
end
