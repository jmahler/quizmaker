<?php

class Application_Form_EditTest extends Zend_Form
{

    public function __construct($size)
    {
        $this->addElementPrefixPath('Application_Form_Decorator',
                             '../application/forms/decorators',
                             'decorator');

        $this->setName('edittest');
        $this->setMethod('post');

        $this->clearDecorators();

        $this->addElement('hidden', 'test_id', array(
            'filters'   => array('Int'),
            # produce only the <input ... tag
            'decorators' => array(
                'ViewHelper',
            ),
        ));

        $this->addElement('text', 'desc', array(
            'ignore'     => false,
            'required'   => true,
            'label'      => 'description',
            'filter'     => array('StringTrim'),
        ));

        $this->addElement('text', 'date', array(
            'ignore'     => false,
            'required'   => true,
            'label'      => 'date',
            'filter'     => array('StringTrim'),
        ));

        $this->addElement('text', "header", array(
            'ignore' => true,
            'decorators' => array(
                array('Pipe',
                  array(
                      'text' => '<table><tr><th>#</th><th>desc</th><th>points</th></tr>',
                  )),
            ),
        ));

        for ($i = 0; $i < $size; $i++) {

            $subform = new Zend_Form_SubForm();

            $subform->addElementPrefixPath(
                            'Application_Form_Decorator',
                            '../application/forms/decorators',
                            'decorator');

            $subform->addElement('hidden', 'problem_id', array(
                'filters'   => array('Int'),
                # produce only the <input ... tag
                'decorators' => array(
                    'ViewHelper',
                ),
            ));

            $subform->addElement('text', 'order', array(
                'label'      => 'order',
                'required'   => false,
                'size' => 3,
                'validators' => array(
                    array('validator' => 'Int'),
                ),
                'value' => $i + 1,
                'decorators' => array(
                    'ViewHelper',
                    'ErrorDot',
                    'HtmlTagTd',
                )));

            # The hidden desc (here) is necessary because
            # the desc later is not submitted in the POST.
            $subform->addElement('hidden', 'hdesc', array(
                'ignore' => false,
                'required'   => false,
                'filter'   => array('StringTrim'),
                # produce only the <input ... tag
                'decorators' => array(
                    'ViewHelper',
                ),
            ));

            $subform->addElement('text', "desc", array(
                'ignore' => true,
                'required'   => false,
                'filter'   => array('StringTrim'),
                'decorators' => array(
                    'Value',
                    'HtmlTagTd',
                ),
            ));


            $subform->addElement('text', 'points', array(
                'label'      => 'points',
                'ignore'    => false,
                'required'   => true,
                'size' => 3,
                'validators' => array(
                    array('validator' => 'Int'),
                ),
                'decorators' => array(
                    'ViewHelper',
                    'ErrorDot',
                    'HtmlTagTd',
                )));

            $this->addSubForm($subform, "prob$i");
        }

        $this->addElement('text', "end-table", array(
            'ignore' => true,
            'decorators' => array(
                array('Pipe',
                  array(
                      'text' => '</table>',
                  )),
            ),
        ));


        $this->addElement('submit', 'submit', array(
            'ignore'    => true,
            'label'     => 'Submit',
        ));

        $this->addElement('hash', 'csrf', array(
            'ignore'    => true,
            'decorators' => array(
                'ViewHelper',
            ),
        ));

        $this->setDecorators(array(
            'FormErrors',
            'FormElements',
#            array('HtmlTag', array(
#                'tag' => 'table',
#                'class' => 'center',
#            )),
            'Form',
        ));

        $this->setSubFormDecorators(array(
            'FormElements',
            array('HtmlTag', array(
                'tag' => 'tr',
                'class' => 'row',
            )),
        ));
    }
}


