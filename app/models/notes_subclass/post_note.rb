class PostNote < Note
  belongs_to :post, foreign_key: :owner_id, class_name: 'Post'

  def object
    post
  end

end
