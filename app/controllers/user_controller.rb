class UserController < UIViewController
  attr_accessor :user

  def initWithUser(user)
    initWithNibName(nil, bundle: nil)
    self.user = user
    self
  end

  def viewDidLoad
    super

    #Fix for iOS7, source: http://kickcode.com/blog/2013/10/09/rubymotion-and-ios-7.html
    #Needed because without this the elements go under the navigation bar
    if UIDevice.currentDevice.systemVersion.floatValue >= 7.0
      self.edgesForExtendedLayout = UIRectEdgeNone
    end

    self.view.backgroundColor = UIColor.whiteColor

    last_label = nil
    ["id", "name", "email"].each do |prop|
      label = UILabel.alloc.initWithFrame(CGRectZero)
      label.text = "#{prop.capitalize}:"

      label.sizeToFit
      if last_label
        label.frame = [
            [last_label.frame.origin.x,
             last_label.frame.origin.y + last_label.frame.size.height],
            label.frame.size]
      else
        label.frame = [[10,10], label.frame.size]
      end
      last_label = label

      self.view.addSubview(label)

      value = UILabel.alloc.initWithFrame(CGRectZero)
      value.text = self.user.send(prop)
      value.sizeToFit
      value.frame = [
          [label.frame.origin.x + label.frame.size.width + 10, label.frame.origin.y],
          value.frame.size]
      self.view.addSubview(value)
    end
    self.title = self.user.name
  end
end