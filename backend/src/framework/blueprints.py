import importlib
import importlib.util as importlib_util


def register_blueprints(app):
    installed_modules = app.config.get("INSTALLED_MODULES")
    for module_name in installed_modules:
        # TODO: Add views to blueprint
        view_modules = f"{module_name}.views"
        if not importlib_util.find_spec(view_modules, __name__):
            pass
        module = importlib.import_module(module_name, __name__)
        bp_name = module_name.split(".")[-1] + "_bp"
        bp = getattr(module, bp_name)
        app.register_blueprint(bp)
