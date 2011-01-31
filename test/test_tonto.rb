require 'digest/md5'
require File.expand_path(File.join(File.dirname(__FILE__), "helper"))

context "Tonto" do
  
  setup do
    @repo = Tonto::Repo.new("example")
  end


  test "repo path" do
    assert_equal "example", @repo.path
  end

  test "db exist?" do
    @repo.create "tonto"
    assert @repo.dbs.include?("tonto")
    assert_equal "tonto", @repo.database
  end

  test "open db" do
    @repo.create "tonto"
    assert @repo.open("tonto")
    assert_equal "tonto", @repo.database
  end

  test "git repo" do
    assert_equal Grit::Repo, @repo.db.class
  end

  test "put a new document with id" do
    assert @repo.put({:id => 12, :name => "tonto", :says => "i'm not stupid :("})
  end

  test "get a document by id" do
    assert @repo.put({:id => 12, :name => "tonto", :says => "i'm not stupid :("})
    assert @repo.get(12)
    assert_equal "tonto", @repo.get(12)["name"]
  end

  test "ask if a key exists" do
    assert @repo.put({:id => 12, :name => "tonto", :says => "i'm not stupid :("})
    assert @repo.exist?(12)
    assert @repo.exists?(12)
  end

  test "update a document" do
    assert @repo.put({:id => "hey!!", :name => "tonto", :wtf => "fwesq"})
    assert @repo.put({:id => "hey!!", :name => "git"})
    assert_equal "git", @repo.get("hey!!")["name"]
  end

  test "remove a document" do
    assert @repo.remove(12)
    assert_equal nil, @repo.get(12)
  end
  
  test "add a blob" do
    assert @repo.put :id => 3, :name => "logo", :blobs => {'octocat' => "octocat.png"}
    digest = Digest::MD5.hexdigest(File.read("octocat.png"))
    assert_equal digest, Digest::MD5.hexdigest(@repo.get(3)["blobs"]["octocat"])
  end
  
  teardown do
    FileUtils.rm_rf(@repo.path)
  end

end
