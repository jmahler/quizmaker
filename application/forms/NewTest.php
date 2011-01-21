<?php

class Application_Form_NewTest extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');

        $this->addElement('hidden', 'test_id', array(
            'filters'   => array('Int'),
        ));

        $this->addElement('text', 'dsc', array(
            'label'     => 'description',
            'required'   => true,
            'filters'   => array('StringTrim'),
        ));

        $this->addElement('submit', 'sumbit', array(
            'ignore'    => true,
            'label'     => 'Submit',
        ));

        $this->addElement('hash', 'csrf', array(
            'ignore'    => true,
        ));
    }
}

