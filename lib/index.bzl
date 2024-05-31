def _output_lib_srv_version(ctx):
    out_file = ctx.actions.declare_file(ctx.attr.output)

    bin_path = ctx.attr._bin_path.files.to_list()[0]

    output_files = [out_file]

    bin_args = ctx.actions.args()
    bin_args.add_all([
        "-v",
        out_file,
    ])

    ctx.actions.run(
        executable = bin_path,
        outputs = output_files,
        arguments = [bin_args],
    )

    return [
        DefaultInfo(
            files = depset(output_files),
        ), 
    ]

output_lib_srv_version = rule(
    implementation = _output_lib_srv_version,
    doc = "Write version from lib-srv binary to a file.",
    attrs = {
        "output": attr.string(
            doc = "Path to write lib-srv version into.",
            mandatory = True,
        ),
        "_bin_path": attr.label(
            default = "@lib_srv_linux//file",
            allow_files = True,
            executable = True,
            mandatory = False,
            cfg = "exec",
        ),
    },
)
