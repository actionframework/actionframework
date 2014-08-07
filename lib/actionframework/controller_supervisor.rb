module ActionFramework
  class ControllerSupervisor
    def run(execute_cmd,env,req,res,url)
      classname, methodname = execute_cmd.split("#")[0], execute_cmd.split("#")[1]

      controllerobject = Object.const_get(classname)

      included = controllerobject.ancestors.select {|o| o.class == Module}
      included = included.map {|includem| includem.to_s}
      if(included.include? "ActionFramework::NextController")
        raise "ActionFramework::NextController is not yet supported, please us ActionFramework::Controller"
      end

      controller = controllerobject.new(env,req,res,url)
      object_from_run_before = controller.execute_run_before
      return object_from_run_before unless object_from_run_before.nil?
      return controller.send(methodname);
    end
  end
end
