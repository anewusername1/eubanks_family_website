# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  class NavigationTabs
    def initialize(template)
      @template = template
    end
    
    def general_links(&block)
      @template.concat("<div class='yui-u first'>\n")
      yield
      @template.concat("</div>\n")
    end
    
    def system_links(&block)
      @template.concat("<div class='yui-u'>\n")
      yield
      @template.concat("</div>\n")
    end
    
    def link(text,url,options={})
      html = ""
      if (options[:root] && @template.request.request_uri == "/") || (@template.request.url.split("/")[3] == url.split("/")[3])
        html << @template.content_tag("li", :class => "ui-state-default ui-corner-top ui-tabs-selected ui-state-active") do
          @template.link_to text, url
        end
      else
        html << @template.content_tag("li", :class => "ui-state-default ui-corner-top") do
          @template.link_to text, url
        end
      end
      return html
    end
  end
  
  class NamespaceNavigationTabs
    def initialize(template)
      @template = template
    end
    
    def link(text,url)
      html = ""
      if "/#{@template.params[:controller]}" == url
        html << @template.content_tag("li", :class => "ui-state-default ui-corner-top ui-tabs-selected ui-state-active") do
          @template.link_to text, url
        end
      else
        html << @template.content_tag("li", :class => "ui-state-default ui-corner-top") do
          @template.link_to text, url
        end
      end
      return html
    end
    
  end
  
  class OptionRedirector
    
    def initialize(template)
      @template = template
    end
    
    def option(name,url)
      "<option value='#{url}'>#{name}</option>" unless @template.request.request_uri.split('?').first == url
    end
    
  end
  
  def namespace_navigation(&block)
    @builder = NamespaceNavigationTabs.new(self)
    concat("<div id='subnav' class='ui-tabs ui-widget'>\n")
    concat("<ul class='ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header'>\n")
    yield @builder
    concat("</ul>\n")
    concat("</div>\n")
  end
  
  def navigation(&block)
    @builder = NavigationTabs.new(self)
    concat("<div id='nav' class='yui-ge ui-tabs ui-widget'>\n") # spaces to make output source readable
    concat("<ul class='ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all'>\n")
    yield @builder
    concat("</ul>\n")
    concat("</div>\n")
  end

  def navigation_for_namespace
    if File.exists?("#{RAILS_ROOT}/app/views/#{params[:controller].split("/")[0]}/_navigation.html.haml")
      render :partial => "#{params[:controller].split("/")[0]}/navigation"
    end
  end
  
  def include_form_scripts(exclude_form_js)
    scripts = "jquery.relatedselects.js", "ui.multiselect.js", "ui.selectmenu.js", "ui.checkbox.js"
    scripts << "form.js" unless exclude_form_js
    content_for :script do
      javascript_include_tag scripts
    end
    content_for :style do
      stylesheet_link_tag "ui.multiselect.css", "ui.selectmenu.css", "ui.checkbox.css"
    end
  end
  
  def option_redirector(name,open=false,blank=nil,&block)
    @builder = OptionRedirector.new(self)
    include_form_scripts(true)
    content_for :script do
      unless open
        javascript_tag do
          %Q{
            $(window).ready(function() {
              $('.select:not(.multiselect)').selectmenu({
            		maxHeight: 400,
            		maxWidth: 200
            	});
              $('##{name}').change(function() {
                if($('##{name} option:selected').attr('value') != '#{name}') {
                  window.location = $('##{name} option:selected').attr('value');
                }
              });
            });
          }
        end
      else
        javascript_tag do
          %Q{
            $(window).ready(function() {
              $('.select:not(.multiselect)').selectmenu({
            		maxHeight: 400,
            		maxWidth: 200
            	});
              $('##{name}').change(function() {
                if($('##{name} option:selected').attr('value') != '#{name}') {
                  window.open($('##{name} option:selected').attr('value'));
                }
              });
            });
          }
        end
      end
    end
    concat("<select id='#{name}' class='select'>")
    concat("<option>#{blank}</option>") if blank  
    yield @builder
    concat("</select>")
  end
  
end
