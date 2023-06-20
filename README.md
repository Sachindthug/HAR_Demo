## Example API Fuzzing project

This project shows an example of [API Fuzzing](https://docs.gitlab.com/ee/user/application_security/api_fuzzing/) using an
HTTP Archive (HAR) file.

For more information about [API Fuzzing see the user documentation](https://docs.gitlab.com/ee/user/application_security/api_fuzzing/).

The following files are part of the API Fuzzing configuration:

| File | Comment |
|:-----|:--------|
|.gitlab-api-fuzzing.yml | API Fuzzing configuration file |
|.gitlab-ci.yml | CI configuration |
|test_rest_target.har | HTTP Archive (HAR) file |

Fuzz testing results are available on the Test tab of a specific Piplines.
"# HAR_Demo" 
