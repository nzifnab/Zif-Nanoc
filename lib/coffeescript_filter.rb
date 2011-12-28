class CoffeeScriptFilter < Nanoc3::Filter
  identifier :coffee

  type :text

  def run(content, params={})
    CoffeeScript.compile content, params
  end
end