class Validator

	attr_accessor :stage

	def initialize(rid)
		@repo = Repo.where(id: rid).first
		@stage = Stage.where(step_number: @repo.status,course_id: @repo.course_id).first
	end

	def validate msg,output
		if @stage && @stage.validation[0] == "cmd_r"
			if (msg =~ @stage.validation[1]).nil?
				return false
			else
				#This will be more complicated!![TODO]
				num = @repo.order.find_index(@repo.status)
				unless num.nil?
					unless(@repo.order[num+1].nil?)
						@repo.status = @repo.order[num+1]
						@repo.save
					end
				end
				return true
			end
		end
	end

	def step_index
		num = @repo.order.find_index(@repo.status)
	end

	def get_user
		if @repo.course_id == 2
			if @repo.order.size == 8
				1
			else
				2
			end
		end
	end

	def next_stage
		@stage = Stage.where(step_number: @repo.status,course_id: @repo.course_id).first
	end

end
