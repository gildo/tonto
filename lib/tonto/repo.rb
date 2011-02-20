require 'grit'

module Tonto

  # Contains the core of the tonto
  class Repo

    attr_accessor :path, :db, :ids

    def initialize(path, db)

      @path = path
      @db = db

      if File.exist?(@path) == false
        Grit::Repo.init(@path)
      end

      @repo = Grit::Repo.new(path)
      @index = Grit::Index.new(@db)

      @dbs =
      # Loads the list of known documents
      # !!! Find a better way to do this !!!
      @repo.commits.any? ? ids = tri.contents.map {|c| c.name.to_i} : ids = []
      @ids = ids
    end

    def tri
      @db.commits.first.nil? ? [] : (@db.commits.first).tree
    end

    def get(id)
      object = tri / File.join(id.to_s, "attributes.json")
      return JSON.parse(object.data, :max_nesting => false)
    end

    def put(doc)
      if @ids.include?(doc[:id])
        old = get(doc[:id].to_s)
        doc.merge!(old)
        add(doc)
      else
        add(doc)
      end
    end

    def add(doc)
      @index.add(File.join(doc[:id].to_s, "attributes.json"), JSON.pretty_generate(doc))
      if doc.has_key?(:blobs) && doc[:blobs].is_a?(Hash)
        doc[:blobs].each do |k,v|
          @index.add(File.join(doc[:id].to_s, k), v)
        end
      end
      @index.commit("document #{doc[:id]}")
    end

    # HORRIBLE!!!11!1!
    def remove(id)
      #@index.delete(File.join(id.to_s, "attributes.json"))
      raise "NotImplemented"
    end

    def exist? id
      @ids.include?(id)
    end

    alias :exists? :exist?
  end
end
