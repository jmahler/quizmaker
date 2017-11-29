
WARNING
=======

Not all files have been converted to YAML yet.
If the file contains blocks such as [question]
it hasn't been converted yet.

It is fairly easy to convert. For example,
the following

    [tags]
    math
    easy
    [/tags]

would be converted to the following YAML.

    tags:
        - math
        - easy

