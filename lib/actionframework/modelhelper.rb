module ActionFramework
	class ModelHelper
		def self.post model,res
			response = model.create(JSON.parse(req.body.string)).to_json
			res.write response
			res.finish
		end

		def self.get model,res
			response = model.all.to_json
			res.write response
			res.finish
		end

		def self.update model,res
			doc = JSON.parse(req.body.string)
			modelfind = model.where(doc[:where])
			response = modelfind.update_attributes(doc[:attributes]).to_json						
			res.write response
			res.finish
		end
	end
end