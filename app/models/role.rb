class Role < ActiveRecord::Base

  def scene_list=(ary)
    names = ary.join(",")
    write_attribute(:scene_list, names)
  end

  def scene_list
    names = read_attribute(:scene_list)
    names.split(",")
  end

  def num_scenes
    self.scene_list.count
  end

end
