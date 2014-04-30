module ActionFramework
  class ControllerSupervisor
    def run(execute_cmd,env,req,res,url)
      classname, methodname = execute_cmd.split("#")[0], execute_cmd.split("#")[1]

      controller = Object.const_get(classname).new(env,req,res,url)
      object_from_run_before = controller.execute_run_before
      return object_from_run_before unless object_from_run_before.nil?
      return controller.send(methodname);
    end
  end
end
