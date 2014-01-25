# == Schema Information
#
# Table name: images
#
#  id                   :integer          not null, primary key
#  title                :string(255)
#  description          :text
#  created_at           :datetime
#  updated_at           :datetime
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class Image < ActiveRecord::Base
  is_impressionable
  
    has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>", :mini => "30x30>" }, :default_url => "/pictures/:style/missing.png"
end
