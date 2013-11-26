module ActionFramework
	class ModelHelper
		def post model,res
			response = model.create(JSON.parse(req.body.string)).to_json
			res.write response
			res.finish
		end

		def get model,res
			response = model.all.to_json
			res.write response
			res.finish
		end

		def update model,res
			doc = JSON.parse(req.body.string)
			modelfind = model.where(doc[:where])
			response = modelfind.update_attributes(doc[:attributes]).to_json						
			res.write response
			res.finish
		end
	end
end