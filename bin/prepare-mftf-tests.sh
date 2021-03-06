#! /usr/bin/env bash

cd ${APP_CODE}
bin/magento config:set cms/wysiwyg/enabled disabled
bin/magento config:set admin/security/admin_account_sharing 1
bin/magento config:set admin/security/use_form_key 0
bin/magento config:set web/seo/use_rewrites 1
bin/magento cache:clean config full_page
vendor/bin/mftf build:project
cp dev/tests/acceptance/.htaccess.sample dev/tests/acceptance/.htaccess
sed -i "s,MAGENTO_BASE_URL=http://devdocs.magento.com/,MAGENTO_BASE_URL=http://localhost:${NGINX_PORT}/," dev/tests/acceptance/.env
vendor/bin/mftf generate:tests
