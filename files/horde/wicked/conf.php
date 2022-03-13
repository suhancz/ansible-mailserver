<?php
/* CONFIG START. DO NOT CHANGE ANYTHING IN OR AFTER THIS LINE. */
// $Hash: b10e8ede9ae4649427bf65c66fc9cea4132ca475
// $Id: bd4277aa5a7033e5846ff0679bf01a19e3be55c9 $
$conf['wicked']['diff_format'] = 'unified';
$conf['wicked']['require_change_log'] = true;
$conf['wicked']['figlet_font'] = '/usr/share/figlet/big.flf';
$conf['wicked']['captcha'] = true;
$conf['wicked']['format'] = 'Default';
$conf['wicked']['lock']['time'] = 10;
$conf['menu']['pages'] = array('Wiki/Home', 'Wiki/Usage', 'RecentChanges', 'AllPages', 'MostPopular', 'LeastPopular');
$conf['storage']['driver'] = 'sql';
$conf['storage']['params']['table'] = 'wicked_pages';
$conf['storage']['params']['historytable'] = 'wicked_history';
$conf['storage']['params']['attachmenttable'] = 'wicked_attachments';
$conf['storage']['params']['attachmenthistorytable'] = 'wicked_attachment_history';
$conf['storage']['params']['driverconfig'] = 'horde';
/* CONFIG END. DO NOT CHANGE ANYTHING IN OR BEFORE THIS LINE. */
