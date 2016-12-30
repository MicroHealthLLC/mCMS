class SettingsController < ApplicationController
  before_action  :authenticate_user!

  before_filter :require_admin

  def index
    @setting = Setting.first || Setting.new
    @theme_setting= Setting.theme
  end

  def create
    @setting = Setting.first || Setting.new
    @setting.attributes= setting_params
    @setting.save

    Setting['application_name'] = params['application_name']
    Setting['email_from'] = params['email_from']
    Setting['conference_url'] = params['conference_url']
    Setting['open_new_tab_url'] = params['open_new_tab_url']
    redirect_to settings_path
  end

  def set_modules
    ems = EnabledModule.pluck(:name)
    rejected_modules = ems.reject{|em| params.has_key? em}
    selected_modules = ems.select{|em| params.has_key? em}
    EnabledModule.where(name: selected_modules).update_all({status: true})
    EnabledModule.where(name: rejected_modules).update_all({status: false})
    redirect_to settings_path
  end

  def set_theme
    theme = Setting.get_theme
    hash = {
        theme_style: "#{params[:theme_style] ? params[:theme_style] : 'smart-style-0'}",
        header: "#{params[:header] ? 'fixed-header' : ''}",
        container: "#{params[:container] ? 'container' : ''}",
        footer: "#{params[:footer] ? 'fixed-page-footer' : ''}",
        topmenu: "#{params[:topmenu] ? 'menu-on-top' : '' }"
    }
    theme.value = hash.to_json
    theme.save
    redirect_to settings_path

  end

  private

  def setting_params
    params.require(:setting).permit(:home_page_content)
  end

end
