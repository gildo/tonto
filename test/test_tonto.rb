require 'digest/md5'
require File.expand_path(File.join(File.dirname(__FILE__), "helper"))

context "db" do
  
  setup do
    @db = Tonto::Repo.new("example")
  end


  test "repo path" do
    assert_equal "example", @db.path
  end

  test "git repo" do
    assert_equal Grit::Repo, @db.db.class
  end

  test "put a new document with id" do
    assert @db.put({:id => 12, :name => "tonto", :says => "i'm not stupid :("})
  end

  test "get a document by id" do
    assert @db.put({:id => 12, :name => "tonto", :says => "i'm not stupid :("})
    assert @db.get(12)
    assert_equal "tonto", @db.get(12)["name"]
  end

  test "ask if a key exists" do
    assert @db.put({:id => 12, :name => "tonto", :says => "i'm not stupid :("})
    assert @db.exist?(12)
    assert @db.exists?(12)
  end

  test "update a document" do
    assert @db.put({:id => "hey!!", :name => "tonto", :wtf => "fwesq"})
    assert @db.put({:id => "hey!!", :name => "git"})
    assert_equal "git", @db.get("hey!!")["name"]
  end

  test "remove a document" do
    assert @db.remove(12)
    assert_equal nil, @db.get(12)
  end
  
  test "add a blob" do
    assert @db.put :id => 3, :name => "logo", :blobs => {'octocat' => "octocat.png"}
    digest = Digest::MD5.hexdigest(File.read("octocat.png"))
    assert_equal digest, Digest::MD5.hexdigest(@db.get(3)["blobs"]["octocat"])
  end
  
  #teardown do
  #  FileUtils.rm_rf(@db.path)
  #end

end
