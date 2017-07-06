require 'i18n'
require 'i18n/backend/fallbacks'
#puts "root is #{settings.root}"
require 'bundler'
Bundler.require
ESTORMHOST='estorm-sms.herokuapp.com'

module Nesta
  module Navigation
    module Renderers
      def current_menu_item_class
              'active'
            end
    end
  end
end

module Nesta
  class App
    not_found do
       haml("404".to_sym)
    end
    set :session_secret, "timor-scratch-web"
    Haml::TempleEngine.disable_option_validator! 
    enable :sessions
    before do
          #puts "session is #{session.inspect}"
          I18n.locale = session[:language] if session[:language]!=nil
          if request.path_info =~ Regexp.new('./$')
            redirect to(request.path_info.sub(Regexp.new('/$'), ''))
          end
          
        end
     configure do
        I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
        I18n.load_path=Dir[File.join(settings.root, 'config/locales', '*.yml')]
        I18n.backend.load_translations
        I18n.locale = 'ba'
        set :estorm_src, 'teds_web_service'
        @wb=EstormLottoGem::WbDrawResults.new
        @wb.set_host(ESTORMHOST)
        #@wb.set_debug 
        set :estorm_result_object, @wb
      end
      post '/lang/:id' do
        lang=params[:id]
        if ['en','tet','ba'].include?(lang)
           puts "setting language to #{lang}"
           I18n.locale = lang 
           session[:language]=lang 
         end
        redirect to('/')
      end
  end
  class Page
    def heading
        regex = case @format
          when :mdown
            /^#\s*(.*?)(\s*#+|$)/
          when :haml
            /^\s*%h1\s+(.*)/
          when :textile
            /^\s*h1\.\s+(.*)/
          end
        markup =~ regex
        val=Regexp.last_match(1) or raise HeadingNotSet, "#{abspath} needs a heading"
        #puts "val is [#{val}]"
        val=eval(val[1..val.size]) if val[0]=='='
        val
      end
    end
end


