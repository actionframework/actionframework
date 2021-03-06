module ActionFramework
  class ControllerSupervisor
    def run(execute_cmd,env,req,res,url)
      if(execute_cmd.class == Array)
        classname,methodname = execute_cmd[0].split("#")[0], execute_cmd[0].split("#")[1]
        controller = Object.const_get(classname).new
        controller.setup(req,res,url,execute_cmd);
        controller.setNext(1);
        controller.send(methodname)

        return controller.this
      else

      classname, methodname = execute_cmd.split("#")[0], execute_cmd.split("#")[1]

      controllerobject = Object.const_get(classname)

      controller = controllerobject.new(env,req,res,url)
      object_from_run_before = controller.execute_run_before
      return object_from_run_before unless object_from_run_before.nil?
      return controller.send(methodname);
      end
    end
  end
end
