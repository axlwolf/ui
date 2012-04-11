//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Apr 10, 2012 12:52:49 PM
// Author: tomyeh

/**
 * The side information.
 * <p>Format: <code>#n1 [#n2 [#n3 #n4]]</code>.
 */
class _SideInfo {
	int top, bottom, left, right;

	static RegExp _reWord = const RegExp(@"(\w+)");

	_SideInfo(String profile, int defaultValue) {
		if (profile != null && !(profile = profile.trim()).isEmpty()) {
			List<int> wds = [];
			for (final Match m in _reWord.allMatches(profile))
				wds.add(Math.parseInt(m.group(0)));

			switch (wds.length) {
			case 0:
				break;
			case 1:
				top = bottom = left = right = wds[0];
				return;
			case 2:
				top = bottom = wds[0];
				left = right = wds[1];
				return;
			case 3:
				top = wds[0];
				left = right = wds[1];
				bottom = wds[2];
				return;
			default:
				top = wds[0];
				right = wds[1];
				bottom = wds[2];
				left = wds[3];
				return;
			}
		}
		top = bottom = left = right = defaultValue;
	}
}
