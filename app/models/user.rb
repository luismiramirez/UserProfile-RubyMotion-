class User
  PROPERTIES = [:id, :name, :email, :phone]
  PROPERTIES.each do |prop|
    attr_accessor prop
  end

  def initialize(properties = {})
    properties.each do |key, value|
      self.send("#{key}=", value)
    end
  end


end