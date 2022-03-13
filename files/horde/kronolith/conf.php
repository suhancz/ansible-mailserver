<?php
/* CONFIG START. DO NOT CHANGE ANYTHING IN OR AFTER THIS LINE. */
// $Hash: 4dd2a98abcb877cdee5e14d20fcf9d9fa0155602
// $Id: 380230c774efc2661b03a58bd71824d28cdc6040 $
$conf['calendar']['params']['table'] = 'kronolith_events';
$conf['calendar']['params']['driverconfig'] = 'horde';
$conf['calendar']['params']['utc'] = true;
$conf['calendar']['driver'] = 'sql';
$conf['storage']['params']['table'] = 'kronolith_storage';
$conf['storage']['params']['driverconfig'] = 'horde';
$conf['storage']['driver'] = 'sql';
$conf['calendars']['driver'] = 'default';
$conf['resource']['params']['table'] = 'kronolith_resources';
$conf['resource']['params']['driverconfig'] = 'horde';
$conf['resource']['params']['utc'] = true;
$conf['resource']['driver'] = 'sql';
$conf['autoshare']['shareperms'] = 'read';
$conf['share']['notify'] = true;
$conf['holidays']['enable'] = true;
$conf['menu']['import_export'] = true;
$conf['maps']['providers'] = array('Google', 'Bing', 'Osm', 'Ocm', 'Mapquest');
$conf['maps']['geocoder'] = 'Google';
$conf['maps']['geodriver'] = 'Mysql';
$conf['maps']['driver'] = 'Horde';
/* CONFIG END. DO NOT CHANGE ANYTHING IN OR BEFORE THIS LINE. */
