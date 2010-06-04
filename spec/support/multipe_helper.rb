module MultipleHelper

  def mutiple_elements_for_model(mock_model ,type)
    mock      = Factory(mock_model.to_sym)
    element   = Factory(type.to_sym)
    element2  = Factory(type.to_sym)

    mock.send(type.to_s.pluralize.to_sym).length.should == 0
    mock.instance_eval("#{type.to_s.pluralize.to_sym} << element")
    mock.send(type.to_s.pluralize.to_sym).length.should == 1

    # check that it accepts only uniques
    mock.instance_eval("#{type.to_s.pluralize.to_sym} << element")
    mock.send(type.to_s.pluralize.to_sym).length.should == 1

    mock.instance_eval("#{type.to_s.pluralize.to_sym} << element2")
    mock.send(type.to_s.pluralize.to_sym).length.should == 2
  end

  def mutiple_elements_for_person(type)
    mutiple_elements_for_model(:person, type)
  end

end
