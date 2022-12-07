// generated from is-ros2/resources/convert__msg.hpp.em
// generated code does not contain a copyright notice

@#######################################################################
@# EmPy template for generating is/rosidl/ros2/<package>/include/is/rosidl/ros2/<package>/msg/convert__msg__<msg>.hpp files
@#
@# Context:
@#  - spec (rosidl_adapter.parser.MessageSpecification)
@#    Parsed specification of the .msg/.idl file
@#  - subfolder (string)
@#    The subfolder / subnamespace of the message
@#    Either 'msg' or 'srv'
@#  - get_header_filename_from_msg_name (function)
@#######################################################################

@{
camelcase_msg_type = spec.base_type.type
underscore_msg_type = get_header_filename_from_msg_name(camelcase_msg_type)

cpp_msg_type = '{}::msg::{}'.format(
      spec.base_type.pkg_name, camelcase_msg_type)

msg_type_string = '{}/msg/{}'.format(
      spec.base_type.pkg_name, camelcase_msg_type)

header_guard_parts = [
    '_IS_SH_ROS2_ROSIDL__ROS2', spec.base_type.pkg_name, 'MSG__CONVERT__MSG',
    underscore_msg_type + '_HPP_']
header_guard_variable = '__'.join([x.upper() for x in header_guard_parts])

namespace_parts = [
    'convert', spec.base_type.pkg_name, 'msg', underscore_msg_type]
namespace_variable = '__'.join(namespace_parts)

ros2_msg_dependency = '{}/msg/{}.hpp'.format(
      spec.base_type.pkg_name, underscore_msg_type)

conversion_dependencies = {}
for field in spec.fields:
    if field.type.is_primitive_type():
        continue

    key = 'is/rosidl/ros2/{}/msg/convert__msg__{}.hpp'.format(
        field.type.pkg_name, field.type.type)
    if key not in conversion_dependencies:
        conversion_dependencies[key] = set([])
    conversion_dependencies[key].add(field.name)
}@

#ifndef @(header_guard_variable)
#define @(header_guard_variable)

#include <stdexcept>

// Include the header for the generic message type
// #include <is/core/Message.hpp>

// Include the header for the conversions
#include <is/utils/Convert.hpp>

// Include the header for the logger
#include <is/utils/Log.hpp>

// Include the header for the concrete ros2 message type
#include <@(ros2_msg_dependency)>

// Include the headers for the message conversion dependencies
@[if conversion_dependencies.keys()]@
@[    for key in sorted(conversion_dependencies.keys())]@
#include <@(key)> // @(', '.join(conversion_dependencies[key]))
@[    end for]@
@[else]@
// <none>
@[end if]@

namespace eprosima {
namespace is {
namespace sh {
namespace ros2 {
namespace @(namespace_variable) {

using Ros2_Msg = @(cpp_msg_type);

void convert_to_ros2([[maybe_unused]] const eprosima::xtypes::ReadableDynamicDataRef& from, [[maybe_unused]] Ros2_Msg& to);
void convert_to_xtype([[maybe_unused]] const Ros2_Msg& from, [[maybe_unused]]eprosima::xtypes::WritableDynamicDataRef to);

static eprosima::is::utils::Logger logger ("is::sh::ROS2");

} //  namespace @(namespace_variable)
} //  namespace ros2
} //  namespace sh

namespace utils {
template<>
struct Convert<sh::ros2::@(namespace_variable)::Ros2_Msg>
    : MessageConvert<
     sh::ros2::@(namespace_variable)::Ros2_Msg,
    &sh::ros2::@(namespace_variable)::convert_to_ros2,
    &sh::ros2::@(namespace_variable)::convert_to_xtype
    > { };

} //  namespace utils
} //  namespace is
} //  namespace eprosima

#endif // @(header_guard_variable)
