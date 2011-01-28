module Tonto

  class Repo

    attr_accessor :path, :repo, :ids

    def initialize(path)

      @path = path

      if File.exist?(@path) == false
        Grit::Repo.init(@path)
      end

      @repo = Grit::Repo.new(path)
      @index = Grit::Index.new(@repo)

      ids!
    end

    def ids!
      # Loads the list of known documents
      # !!! Find a better way to do this !!!
      @repo.commits.any? ? ids = tri.contents.map {|c| c.name.to_i} : ids = []
      @ids = ids
    end

    def tri
      @repo.commits.first.nil? ? [] : (@repo.commits.first).tree
    end

    def get(id)
      if exists?(id)
        object = tri / File.join(id.to_s, "attributes.json")
        return JSON.parse(object.data, :max_nesting => false)
      else
        return "#{id} doesn't exists"
      end
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
      ids!
      @ids.include?(id)
    end

    alias :exists? :exist?
  end
end
