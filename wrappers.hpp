#pragma once

#include <kv/interval.hpp>

namespace wrappers{
	using kv_interval = ::kv::interval<double>;

	// workaround
	void set_lower(kv_interval &i, double x)
	{
		i.lower() = x;
	}

	// workaround
	void set_upper(kv_interval &i, double x)
	{
		i.upper() = x;
	}
}

