class String
  def titleize
    articles = %w{a an as it of the}

    split.map_with_index { |w, i|
      case i
      when 0 then w.capitalize
      else        articles.includes?(w) ? w.downcase : w.capitalize
      end
    }.join ' '
  end
end
