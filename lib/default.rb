# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
include Nanoc3::Helpers::LinkTo
include Nanoc3::Helpers::Rendering

module Nanoc3::Helpers::LinkTo
  # Gives the ability to use link_to block syntax like rails allows:
  #    = link_to "/something/", :class => 'mylink' do
  #      %img{:src => '/images/someimage'}
  #      A link!
  alias_method :old_link_to, :link_to
  def link_to(text, path={}, options={}, &block)
    if block_given?
      options = path
      path = text
      text = capture(&block)
    end
    old_link_to(text, path, options)
  end
end

# Gives you the correct item based on the localization you're currently
# looking at.
module NanocItem
  def find(type, obj=nil, rep=nil)
    if obj.nil?
      obj = type
      type = nil
    end

    rep = :"locale_#{I18n.locale}" if rep.nil?

    regex = %r{((.*)/)*#{obj}/$}
    regex = %r{#{type}/#{regex}} unless type.nil?
    regex = %r{^/#{regex}}
    regex = %r{^/$} if obj == "/"
    item = (item = @items.find{|i| i.identifier =~ regex}) && item.rep_named(rep)
    if !item
      puts "WARNING:  Item #{obj} not found"
      return @item.rep_named(:"locale_#{I18n.locale}")
    end
    item
  end
end

module RandomHelpers
  def include_js_file(filename)
    %{<script src="/js/#{filename}" type="text/javascript"></script>}
  end
end

include NanocItem
include RandomHelpers