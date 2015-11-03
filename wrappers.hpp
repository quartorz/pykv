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

	// workaround
	double kv_width(const kv_interval &i)
	{
		return width(i);
	}

	// workaround
	double kv_rad(const kv_interval &i)
	{
		return rad(i);
	}

	// workaround
	double kv_mid(const kv_interval &i)
	{
		return mid(i);
	}

	// workaround
	double kv_median(const kv_interval &i)
	{
		return median(i);
	}

	// workaround
	double kv_norm(const kv_interval &i)
	{
		 return norm(i);
	}

	// workaround
	double kv_mag(const kv_interval &i)
	{
		return mag(i);
	}

	// workaround
	bool kv_in(const double &a, const kv_interval &i)
	{
		return in(a, i);
	}

	// workaround
	bool kv_zero_in(const kv_interval &i)
	{
		return zero_in(i);
	}

	// workaround
	bool kv_subset(const kv_interval &x, const kv_interval &y)
	{
		return subset(x, y);
	}

	// workaround
	bool kv_proper_subset(const kv_interval &x, const kv_interval &y)
	{
		return proper_subset(x, y);
	}

	// workaround
	bool kv_overlap(const kv_interval &x, const kv_interval &y)
	{
		return overlap(x, y);
	}

	// workaround
	kv_interval kv_intersect(const kv_interval &x, const kv_interval &y)
	{
		return intersect(x, y);
	}
}

