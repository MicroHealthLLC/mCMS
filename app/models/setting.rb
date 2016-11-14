class Setting < ApplicationRecord

  def self.theme
    JSON.parse(get_theme.value ||  {theme_style: 'smart-style-0' }.to_json )
  end


  def self.get_theme
    where(setting_type: 'cms_theme').first_or_initialize
  end

  def self.theme_style
    theme['theme_style']
  end
end
