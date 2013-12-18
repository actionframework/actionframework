module ActionFramework
	class ModelHelper
		def self.post model,res
			if(model.create?)
				response = model.create(JSON.parse(req.body.string)).to_json
				res.write response	
			else
				res.write({:error => "403 Forbidden"}.to_json)
			end
			res.finish
		end

		def self.get model,res
			if(model.fetch?)
				response = model.all.to_json
				res.write response
			else
				res.write({:error => "403 Forbidden"}.to_json)
			end
			res.finish
		end

		def self.update model,res
			if(model.update?)
				doc = JSON.parse(req.body.string)
				modelfind = model.where(doc[:where])
				response = modelfind.update_attributes(doc[:attributes]).to_json						
				res.write response
			else
				res.write({:error => "403 Forbidden"}.to_json)
			end
			res.finish
		end
	end
end